From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 3 Apr 2018 00:13:37 +0000
Subject: [RFC PATCH 8/8] nvmet: add configfs interface for target passthru
In-Reply-To: <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-9-chaitanya.kulkarni@wdc.com>
 <be832a05-3906-7087-30ed-f20784128272@deltatee.com>
Message-ID: <9CC85AAF-DFCD-4192-811D-E2472349786B@wdc.com>

In general, I?ve implemented the configfs structure in such a way
it will keep pt configuration isolated from the subsystem management.

Please see my inline comment for more details.

On 3/30/18, 11:14 AM, "Logan Gunthorpe" <logang@deltatee.com> wrote:

    
    
    On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
    > This patch adds configfs interface for target passthru
    > ctrl management.
    > 
    > The new directory "pt" under nvmet configfs is added to
    > configure passthru ctrl (pt-ctrl). Once all the fields
    > for the pt-ctrl are set user can enable the pt-ctrl through
    > configfs.
    > 
    > The new directory pt is parallel to the subsystem and has similar
    > attributes as default subsystem, each passthru ctrl is represented
    > as one subsystem. Since we allow ctrl passthru we don't export or
    > allow user to access the passthru namespace(s) in the configfs.
    
    I *really* dislike this interface. Not only is the "pt" directory
    confusing to the user, it's nearly identical to what a subsystem is. 

[CK] Actually pt directory is not identical to what subsystem
is in following ways: -

1. Configuration: -
subsystem: - we use configfs namespaces directory structure to configure the ns.
pt: - we use NVMe ns-mgmt commands which allows host to configure the ns.
2. Internal representation: -
subsystem: - we create target ns object for each ns.
pt: - we don't create target ns object for each ns.
3. NS-Management: -
subsystem: - Namespaces are created and configured on the target side with
only configfs interface.
pt: - Namespaces are created from the host side (and optionally on the
target side with tools before pt configuration) without going through configfs
interface. 
Also having different directories actually makes user aware about what is being
configured.

    So as developers, if we want to add a config option to a subsystem we also
    have to add it to the equivalent pt. I've already seen one patch set
    that would be mutually exclusive to this only because of the
    configuration mess.

[CK] We should only add configfs options to the pt interface if
it is supported by the pt interface, if it is not supported by the
pt interface then it we should avoid it in the configfs, current proposal
provides developers flexibility to have only supported options for pt. In this way
we keep the distinction clear about subsystem and pt.
Also, we reuse most of the subsystem code for the attributes
so even in future subsys gets a new attribute there shouldn't
be much duplication of the code.

If we really don?t want have ?pt? parallel to ?subsystems? then please have a look at 3  rd
approach of pt under subsystem, this way we will share the subsystems attributes, here
as you mentioned we can prevent creation of the namespaces through configfs when
?attr_ctrl_path? is configured.
For reference providing existing Subsystem (1) and pt (2) configuration.

1. Existing Subsystem: -


/sys/kernel/config/
??? nvmet
    ??? hosts
    ??? ports
    ?   ??? 1
    ?       ??? addr_adrfam
    ?       ??? addr_traddr
    ?       ??? addr_treq
    ?       ??? addr_trsvcid
    ?       ??? addr_trtype
    ?       ??? referrals
    ?       ??? subsystems
    ?           ??? testnqn1 -> ../../../../nvmet/subsystems/testnqn1
    ??? pt
    ??? subsystems
        ??? testnqn1
            ??? allowed_hosts
            ??? attr_allow_any_host
            ??? attr_serial
            ??? attr_version
            ??? namespaces
                ??? 1
                    ??? device_nguid
                    ??? device_path
                    ??? device_uuid
                    ??? enable

2. Current PT implementation: -


/sys/kernel/config/
??? nvmet
    ??? hosts
    ??? ports
    ?   ??? 1
    ?       ??? addr_adrfam
    ?       ??? addr_traddr
    ?       ??? addr_treq
    ?       ??? addr_trsvcid
    ?       ??? addr_trtype
    ?       ??? referrals
    ?       ??? subsystems
    ?           ??? nvme0 -> ../../../../nvmet/pt/nvme0
    ??? pt
    ?   ??? nvme0
    ?       ??? allowed_hosts
    ?       ??? attr_allow_any_host
    ?       ??? attr_ctrl_path
    ?       ??? attr_enable
    ?       ??? attr_serial
    ?       ??? attr_version
    ??? subsystems

11 directories, 10 files

 3. PT under Subsystem proposed implementation: -


/sys/kernel/config/
??? nvmet
    ??? hosts
    ??? ports
    ?   ??? 1
    ?       ??? addr_adrfam
    ?       ??? addr_traddr
    ?       ??? addr_treq
    ?       ??? addr_trsvcid
    ?       ??? addr_trtype
    ?       ??? referrals
    ?       ??? subsystems
    ?           ??? testnqn1 -> ../../../../nvmet/subsystems/testnqn1
    ??? subsystems
        ??? nvme0
            ??? allowed_hosts
            ??? attr_allow_any_host
            ??? attr_serial
            ??? attr_version
             ??? namespaces
     ??? pt
    	     ??? attr_ctrl_path
                      ???attr_enable


    I'd much rather see either a couple new attributes in the existing
    subsystem or some mechanism such that if you create a namespace that
    points to a controller (eg /dev/nvme1) it takes it as though you're
    trying to pass through the whole NVMe device.

[CK] That is exactly what I'd try to avoid since it will entangle the code of
subsystem and pt. In case if everyone is okay with this approach, let?s do this.

 (The code would need to
    ensure that a passthrough subsystem configured this way could only have
    exactly one namespace.)

[CK] This imposes burden on the sysadmin to have a mandatory
namespace. Since it is a ctrl pass-through we should avoid use of
both pass-through-ns, configfs-namespaces directory and internal
target ns structure as much as possible.


 I think that would be a lot more intuitive than
    a directory label "pt" and prevents all the duplication of what a
    subsystem is.
    
    Logan
    
