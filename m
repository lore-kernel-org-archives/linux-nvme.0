From: hare@suse.de (Hannes Reinecke)
Date: Fri, 3 Nov 2017 11:24:49 +0100
Subject: [PATCH] nvme_fc auto-connect scripts
In-Reply-To: <c71cc8e0-79d3-a135-1b3c-32b081d687ff@suse.de>
References: <20171009201032.2018-1-jsmart2021@gmail.com>
 <e542bb4d-946f-a080-5701-f8019fdbc752@suse.de>
 <352f980c-2422-f917-a551-99bedf27e0ab@broadcom.com>
 <f0300e47-e219-19f9-1495-a662f9062b4d@suse.de>
 <159cfcc6-40e8-9062-7341-9a3de5f177af@broadcom.com>
 <c71cc8e0-79d3-a135-1b3c-32b081d687ff@suse.de>
Message-ID: <34c754eb-79d0-8d39-e82d-6182029b2871@suse.de>

On 11/03/2017 10:37 AM, Hannes Reinecke wrote:
> On 10/28/2017 06:08 PM, James Smart wrote:
[ .. ]
>>
>> The main reason for the systemd use was the potential duration of the
>> resulting nvme connect-all. The scripts are simple if udev makes the
>> nvme cli call and don't require anything other than a single generic
>> rule. But given its potential stalls, very bad.
>>
>> If I understand you correctly, what you describe requires apriori
>> knowledge of the connections in order to add the udevs rule. This is a
>> step backward from current FC behavior and what users are used to.
>>
> So, here's my take for this:
> 
> # cat 65-nvme-fc-connect-nvmf-test-subsys1.rules
> SUBSYSTEM!="block, GOTO="nvme_autoconnect_end"
> ACTION!="add|change", GOTO="nvme_autoconnect_end"
> ENV{FC_EVENT}!="nvmediscovery", GOTO="nvme_autoconnect_end"
> ENV{NVMEFC_HOST_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
> ENV{NVMEFC_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
> RUN+="/usr/sbin/nvme connect -t fc \
> --host-traddr=$env{NVMEFC_HOST_TRADDR} \
> -n nvmf-test-subsys1 -a $env{NVMEFC_TRADDR}"
> LABEL="nvme_autoconnect_end"
> 
> Obviously, we would need to filter for the appropriate values of traddr
> and host_traddr to not attempt connections to non-existing namespaces.
> 
> However, I do see the problem of nvme connect stalls; if we were having
> a systemd service we would solve this issue nicely, indeed.
> But then we shouldn't activate the service, it should rather be
> activated per default, but depend on a specifice NVMe-FC _target_, which
> should be presented by the discovery event.
> 
> Let's see what I can cobble together here.
> 
Upon further review, we actually _could_ avoid delays upon the 'nvme
connect' call if we were delegating the call to the connect workqueue:

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1ca100a..6c36a93 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3302,28 +3302,7 @@ nvme_fc_init_ctrl(struct device *dev, struct
nvmf_ctrl_options *opts,

        nvme_fc_set_ctrl_devloss(ctrl, opts);

-       ret = nvme_fc_create_association(ctrl);
-       if (ret) {
-               ctrl->ctrl.opts = NULL;
-               /* initiate nvme ctrl ref counting teardown */
-               nvme_uninit_ctrl(&ctrl->ctrl);
-
-               /* Remove core ctrl ref. */
-               nvme_put_ctrl(&ctrl->ctrl);
-
-               /* as we're past the point where we transition to the ref
-                * counting teardown path, if we return a bad pointer here,
-                * the calling routine, thinking it's prior to the
-                * transition, will do an rport put. Since the teardown
-                * path also does a rport put, we do an extra get here to
-                * so proper order/teardown happens.
-                */
-               nvme_fc_rport_get(rport);
-
-               if (ret > 0)
-                       ret = -EIO;
-               return ERR_PTR(ret);
-       }
+       queue_delayed_work(nvme_fc_wq, &ctrl->connect_work, 0);

Then it should be perfectly possible to have a udev rule with just
kicking off the 'nvme connect', any eventual cleanup would be done by
either the number of reconnects being exhausted or dev_loss_tmo kicking in.
James?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
