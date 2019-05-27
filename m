From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 27 May 2019 14:05:09 +0900
Subject: [PATCH 1/2] nvme-cli: don't try to disconnect for ctrl with pcie
 transport
In-Reply-To: <DM6PR04MB452155C6620AF9B2BF47B093860A0@DM6PR04MB4521.namprd04.prod.outlook.com>
References: <20190516172350.11864-1-minwoo.im.dev@gmail.com>
 <20190516172350.11864-2-minwoo.im.dev@gmail.com>
 <DM6PR04MB452155C6620AF9B2BF47B093860A0@DM6PR04MB4521.namprd04.prod.outlook.com>
Message-ID: <20190527050508.GA933@minwooim-desktop>

On 19-05-16 23:08:31, Chaitanya Kulkarni wrote:
> Looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> 
> On 5/16/19 10:24 AM, Minwoo Im wrote:
> > If a host system has both pcie and fabrics controllers, the following
> > nvme-cli disconnect-all command will might not be working because
> > contrlller with pcie transport does not have delete_controller in sysfs.
> 
> Can we please move following block of the output into the comment(not
> sure if that is the right name)
> 
> of the patch section ? i.e. after signoff... line. This can be done at
> the merge time also.

Chaitanya,

Sorry for lately response here.  I don't get what you really mean here.
Could you please explain why should we move the following output lines
to after --- blocks ?

> 
> ---
> 
> output
> 
> ---
> 
> fabrics.c | 2 ++
> 
> >
> > root at target:~# nvme list
> > Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
> > ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
> > /dev/nvme0n1     foo                  QEMU NVMe Ctrl                           1         536.87  MB / 536.87  MB    512   B +  0 B   1.0
> > /dev/nvme1n1     b92326b9b2323bf0     Linux                                    1         134.22  MB / 134.22  MB    512   B +  0 B   5.1.0-rc
> > /dev/nvme2n1     65fa04eddd9bbac0     Linux                                    1         134.22  MB / 134.22  MB    512   B +  0 B   5.1.0-rc
> >
> > root at target:~/nvme-cli.git# nvme disconnect-all
> > Failed to open /sys/class/nvme/nvme0/delete_controller: No such file or directory
> >
> > This patch checks the transport type of the controller in iteration.
> >
> > Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> > ---
> >  fabrics.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fabrics.c b/fabrics.c
> > index 511de06..733a24b 100644
> > --- a/fabrics.c
> > +++ b/fabrics.c
> > @@ -1196,6 +1196,8 @@ int disconnect_all(const char *desc, int argc, char **argv)
> >  
> >  		for (j = 0; j < subsys->nctrls; j++) {
> >  			struct ctrl_list_item *ctrl = &subsys->ctrls[j];
> > +			if (!strcmp(ctrl->transport, "pcie"))
> 
> I didn't looked into the case but it is safe to use strcasecmp()? if you
> are sure strcmp()
> 
> will do the job, please disregard this comment.

strcmp() is enough to go here :)
