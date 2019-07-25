From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Jul 2019 22:53:54 +0900
Subject: [PATCH 5/5] lnvm: introduce alias geometry for id-ns for lnvm
In-Reply-To: <519420f6-350d-05e9-4938-45bc529b9a26@lightnvm.io>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-6-minwoo.im.dev@gmail.com>
 <519420f6-350d-05e9-4938-45bc529b9a26@lightnvm.io>
Message-ID: <20190725135354.GE3018@minwoo-desktop>

Hi Matias,

On 19-07-24 14:29:38, Matias Bj?rling wrote:
> On 23/07/2019 20.36, Minwoo Im wrote:
> > Now we have 2.0 OCSSD spec which introudces Geometry command instead of
> > Identity or something else.  This patch just adds an alias for this
> > command for the given NVMe namespace with backward compatibility.
> > 
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: Matias Bjorling <mb at lightnvm.io>
> > Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> > ---
> >   plugins/lnvm/lnvm-nvme.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/plugins/lnvm/lnvm-nvme.h b/plugins/lnvm/lnvm-nvme.h
> > index f091f7b..2879a0b 100644
> > --- a/plugins/lnvm/lnvm-nvme.h
> > +++ b/plugins/lnvm/lnvm-nvme.h
> > @@ -11,7 +11,7 @@ PLUGIN(NAME("lnvm", "LightNVM specific extensions"),
> >   	COMMAND_LIST(
> >   		ENTRY("list", "List available LightNVM devices", lnvm_list)
> >   		ENTRY("info", "List general information and available target engines", lnvm_info)
> > -		ENTRY("id-ns", "List geometry for LightNVM device", lnvm_id_ns)
> > +		ENTRY("id-ns", "List geometry for LightNVM device", lnvm_id_ns, "geometry")
> >   		ENTRY("chunk-log", "Chunk information by Get Log Page", lnvm_chunk_log)
> >   		ENTRY("init", "Initialize media manager on LightNVM device", lnvm_init)
> >   		ENTRY("create", "Create target on top of a LightNVM device", lnvm_create_tgt)
> 
> Hi Minwoo,
> 
> How about also rewording the text to:
> 
> List geometry structure for LightNVM device?

No problem with that.  Not a native speaker so always welcome this kind
of review :)

> Also, do we want to use a short hand (instead of writing geometry in full)?

You mean like "geo" or something like this?

> How is it done elsewhere in the nvme-cli code?

Actually only place that has this kind of _alias_ is fw-commit
subcommand:

```c
	ENTRY("fw-commit", "Verify and commit firmware to a specific slot (fw-activate in old version < 1.2)", fw_commit, "fw-activate")
```

The firmware commit command has been renamed to "fw-activate" so that
this kind of alias has been applied.

But in this patch's case, I just wanted to make sure that the "id-ns"
subcommand is for Geometry command that what the SPEC exactly says.

You have any other words in your mind?  It would be great if you can
propose here :)  OR do you want it as it is with "id-ns" only?

> Regards,
> 
> Matias
> 

Thanks!
