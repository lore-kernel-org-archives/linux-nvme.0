From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 29 Jan 2018 21:34:39 +0000
Subject: Reconnect on RDMA device reset
In-Reply-To: <26056a83-2f81-6b56-7bbf-fcecfc4518d6@grimberg.me>
References: <CADZhsQqDFc1NWmsihOwki8_2Zj0HuYKC_N_x0jMnCtU9Rww1UA@mail.gmail.com>
 <f0a14240-1566-1bae-1b9f-21880bc3f3a0@grimberg.me>
 <CADZhsQqvK0LMd9sfxzz+x_5qVnoi4FP0FCFMsTPjpeXyqfXKew@mail.gmail.com>
 <77cef33e-a563-97fc-7ba6-69f220f1be84@grimberg.me>
 <1516904022.27592.187.camel@redhat.com>
 <26056a83-2f81-6b56-7bbf-fcecfc4518d6@grimberg.me>
Message-ID: <1517261678.2687.49.camel@wdc.com>

On Mon, 2018-01-29@22:36 +0200, Sagi Grimberg wrote:
> > I *think* for SRP this is already the case.  The SRP target uses the
> > kernel LIO framework, so if you bounce the device under the SRPt layer,
> > doesn't the config get preserved?  So that when the device came back up,
> > the LIO configuration would still be there and the SRPt driver would see
> > that? Bart?
> 
> I think you're right. I think we can do that if we keep the listener
> cm_id device node_guid and when a new device comes in we can see if we 
> have a cm listener on that device and re-listen. That is a good idea
> Doug.

Sorry that I hadn't noticed this e-mail thread earlier and that I had not yet
replied. The SRPT config should get preserved as long as the device removal
function (srpt_remove_one()) does not get called.

> > For the SRP client, I'm almost certain it will try to reconnect since it
> > uses a user space daemon with a shell script that restarts the daemon on
> > various events.  That might have changed...didn't we just take a patch
> > to rdma-core to drop the shell script?  It might not reconnect
> > automatically with the latest rdma-core, I'd have to check.  Bart should
> > know though...
> 
> srp driver relies on srp_daemon to discover and connect again over the
> new device. iSER relies on iscsiadm to reconnect. I guess it should be
> the correct approach for nvme as well (which we don't have at the
> moment)...

There are two mechanisms for the SRP initiator to make it reconnect to an SRP
target:
1. srp_daemon. Even with the latest rdma-core changes srp_daemon should still
   discover SRP targets and reconnect to the target systems it is allowed to
   reconnect to by its configuration file.
2. The reconnection mechanism in the SCSI SRP transport layer. See also the
   documentation of the reconnect_delay in
   https://www.kernel.org/doc/Documentation/ABI/stable/sysfs-transport-srp

Bart.
