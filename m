From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Wed, 10 Jul 2019 15:40:07 +0000
Subject: Should hot removed devices close open namespace bd references?
In-Reply-To: <ed33a95f-1202-a5aa-c0ec-c91a8810a082@grimberg.me>
References: <d7027ad47e28339f13eb2d7f1bff4c7749da1160.camel@intel.com>
 <32a2e339-b948-43fe-72a3-77eb2e626c63@grimberg.me>
 <4eddc7d98f49abf4255c31fbe4412ce9e3877c06.camel@intel.com>
 <ed33a95f-1202-a5aa-c0ec-c91a8810a082@grimberg.me>
Message-ID: <1d2ca793b6836b1af71117c5bb7295654e29a29d.camel@intel.com>

On Tue, 2019-07-09@19:13 -0700, Sagi Grimberg wrote:
> > > Its the controller that is not released (as the open ns handle holds
> > > a reference to it). But what is the old controller state? the code
> > > is supposed to allow this check if the old controller is in
> > > DELETING/DEAD.
> > The state is 6 (DEAD). I added some sysfs code to show the controller
> > state:
> > 
> 
> I think I understand the problem, can you try with:
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e28717d11f9a..04d5ce1a42c1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2419,8 +2419,8 @@ static bool nvme_validate_cntlid(struct 
> nvme_subsystem *subsys,
>          lockdep_assert_held(&nvme_subsystems_lock);
> 
>          list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
> -               if (ctrl->state == NVME_CTRL_DELETING ||
> -                   ctrl->state == NVME_CTRL_DEAD)
> +               if (tmp->state == NVME_CTRL_DELETING ||
> +                   tmp->state == NVME_CTRL_DEAD)
>                          continue;
> 
>                  if (tmp->cntlid == ctrl->cntlid) {
> --

Thanks Sagi

This does resolve the issue and restore the previous behavior.
The new controller and namespace instance get named nvmeN and nvmeMn2
(because it adds to the now-stale subsystem and increments the
instance)

It might be nice to see if the instance could somehow be released on
deleting/dead, otherwise this behavior seems fine.


You can give it my tested-by
Tested-by: Jon Derrick <jonathan.derrick at intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190710/60d69ceb/attachment.bin>
