/obj/item/stack/teeth
    name = "teeth"
    singular_name = "tooth"
    w_class = 1
    force = 0
    throwforce = 0
    max_amount = 32
    gender = PLURAL
    desc = "Welp. Someone had their teeth knocked out."
    icon = 'icons/obj/surgery.dmi'
    icon_state = "tooth1"
    drop_sound = null

/obj/item/stack/teeth/New()
    ..()
    icon_state = "tooth[rand(1,3)]"

/obj/item/stack/teeth/human
    name = "human teeth"
    singular_name = "human tooth"

/obj/item/stack/teeth/generic //Used for species without unique teeth defined yet
    name = "teeth"

/obj/item/stack/proc/zero_amount()//Teeth shit
    if(amount < 1)
        qdel(src)
        return 1
    return 0

/obj/item/organ/external/head/proc/get_teeth() //returns collective amount of teeth
    var/amt = 0
    if(!teeth_list) teeth_list = list()
    for(var/obj/item/stack/teeth in teeth_list)
        amt += teeth.amount
    return amt
/obj/item/organ/external/head/proc/knock_out_teeth(throw_dir, num=32) //Won't support knocking teeth out of a dismembered head or anything like that yet.
    num = Clamp(num, 1, 32)
    var/done = 0
    if(teeth_list && teeth_list.len) //We still have teeth
        var/stacks = rand(1,3)
        for(var/curr = 1 to stacks) //Random amount of teeth stacks
            var/obj/item/stack/teeth/teeth = pick(teeth_list)
            if(!teeth || teeth.zero_amount()) return //No teeth left, abort!
            var/drop = round(min(teeth.amount, num)/stacks) //Calculate the amount of teeth in the stack
            var/obj/item/stack/teeth/T = new teeth.type(owner.loc, drop)
            teeth.use(drop)
            T.add_blood(owner)
            playsound(owner, "trauma", 75, 0)
            var/turf/target = get_turf(owner.loc)
            var/range = rand(1, 3)
            for(var/i = 1; i < range; i++)
                var/turf/new_turf = get_step(target, throw_dir)
                target = new_turf
                if(new_turf.density)
                    break
            T.throw_at(get_edge_target_turf(T,pick(alldirs)),rand(1,3),30)
            T.loc:add_blood(owner)
            teeth.zero_amount() //Try to delete the teeth
            done = 1
            teeth_lost = drop
        return done