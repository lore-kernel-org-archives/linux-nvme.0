From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 9 Jul 2019 19:13:36 -0700
Subject: Should hot removed devices close open namespace bd references?
In-Reply-To: <4eddc7d98f49abf4255c31fbe4412ce9e3877c06.camel@intel.com>
References: <d7027ad47e28339f13eb2d7f1bff4c7749da1160.camel@intel.com>
 <32a2e339-b948-43fe-72a3-77eb2e626c63@grimberg.me>
 <4eddc7d98f49abf4255c31fbe4412ce9e3877c06.camel@intel.com>
Message-ID: <ed33a95f-1202-a5aa-c0ec-c91a8810a082@grimberg.me>


>> Its the controller that is not released (as the open ns handle holds
>> a reference to it). But what is the old controller state? the code
>> is supposed to allow this check if the old controller is in
>> DELETING/DEAD.
> The state is 6 (DEAD). I added some sysfs code to show the controller
> state:
> 

I think I understand the problem, can you try with:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e28717d11f9a..04d5ce1a42c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2419,8 +2419,8 @@ static bool nvme_validate_cntlid(struct 
nvme_subsystem *subsys,
         lockdep_assert_held(&nvme_subsystems_lock);

         list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
-               if (ctrl->state == NVME_CTRL_DELETING ||
-                   ctrl->state == NVME_CTRL_DEAD)
+               if (tmp->state == NVME_CTRL_DELETING ||
+                   tmp->state == NVME_CTRL_DEAD)
                         continue;

                 if (tmp->cntlid == ctrl->cntlid) {
--
