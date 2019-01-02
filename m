From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Jan 2019 15:33:34 -0700
Subject: OWC Aura Pro X SSD
In-Reply-To: <3fe2c91b-d6b7-3f42-8af4-0620d7920a3d@vfemail.net>
References: <3fe2c91b-d6b7-3f42-8af4-0620d7920a3d@vfemail.net>
Message-ID: <20190102223334.GA9734@localhost.localdomain>

On Wed, Jan 02, 2019@10:03:00PM +0000, Winston Smith wrote:
> i decided to try and look at my ssd directly, and here i get to the meat
> of my question for this mailing list. i read about the power saving
> kernel patch on the arch wiki:
> 
> https://wiki.archlinux.org/index.php/Solid_state_drive/NVMe#NVME_Power_Saving_Patch
> 
> when i run "nvme get-feature -f 0x0c -H /dev/nvme0" i get an error:
> 
> "NVMe Status:INVALID_FIELD"

This is saying your controller doesn't support autonomous power state
transitions. For such devices, you can reach your their low power states
only through direct host managed transitions, but the driver doesn't
support that mode.
 
> i ran "nvme id-ctrl /dev/nvme0", here is the output:
> 
> > NVME Identify Controller:
> > ps    0 : mp:9.00W operational enlat:5 exlat:5 rrt:0 rrl:0
> >           rwt:0 rwl:0 idle_power:- active_power:-
> > ps    1 : mp:4.60W operational enlat:30 exlat:30 rrt:1 rrl:1
> >           rwt:1 rwl:1 idle_power:- active_power:-
> > ps    2 : mp:3.80W operational enlat:30 exlat:30 rrt:2 rrl:2
> >           rwt:2 rwl:2 idle_power:- active_power:-
> > ps    3 : mp:0.0700W non-operational enlat:30000 exlat:10000 rrt:3 rrl:3
> >           rwt:3 rwl:3 idle_power:- active_power:-
> > ps    4 : mp:0.0050W non-operational enlat:50000 exlat:10000 rrt:4 rrl:4
> >           rwt:4 rwl:4 idle_power:- active_power:-
> 
> is nvme power saving available with this (admittedly exotic) ssd? i see
> the 'ps' fields in the id_ctrl output, but don't know what to do about
> them. how can i find the correct feature number to use to check the
> power saving status of my nvme drive?

You can mess with those with nvme-cli using 'set-feature -f 2' with a
'-v' between 0 and 3, but you'll likely just get IO timeouts if you
select a non-operational power state since this SSD won't automatically
transition to operation on a new read/write command.
