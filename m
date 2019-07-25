From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Jul 2019 22:43:32 +0900
Subject: [PATCH 4/5] lnvm: introduce chunk-log command for chunk info
In-Reply-To: <a40ea502-e293-e07c-9f7b-e5f9cc118adf@lightnvm.io>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-5-minwoo.im.dev@gmail.com>
 <a40ea502-e293-e07c-9f7b-e5f9cc118adf@lightnvm.io>
Message-ID: <20190725134332.GC3018@minwoo-desktop>

Hi Matias,

On 19-07-24 14:27:10, Matias Bj?rling wrote:
> On 23/07/2019 20.36, Minwoo Im wrote:
> > To retrieve the chunk information from the nvme namespae for the given
> > OCSSD, we can just do like:
> > 	nvme lnvm chunk-log /dev/nvme0n1 --output-format=normal
> > 
> > This will calculate the data length from the geometry data structure
> > which might be retrieved by a Geometry command(Identity for 1.2 spec.).
> > Then it will request get log page API for 1.3 NVMe spec to get the
> > entries which indicate chunk information.
> > 
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: Matias Bjorling <mb at lightnvm.io>
> > Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> > ---
> > diff --git a/plugins/lnvm/lnvm-nvme.h b/plugins/lnvm/lnvm-nvme.h
> > index 3d5cbc5..f091f7b 100644
> > --- a/plugins/lnvm/lnvm-nvme.h
> > +++ b/plugins/lnvm/lnvm-nvme.h
> > @@ -12,6 +12,7 @@ PLUGIN(NAME("lnvm", "LightNVM specific extensions"),
> >   		ENTRY("list", "List available LightNVM devices", lnvm_list)
> >   		ENTRY("info", "List general information and available target engines", lnvm_info)
> >   		ENTRY("id-ns", "List geometry for LightNVM device", lnvm_id_ns)
> > +		ENTRY("chunk-log", "Chunk information by Get Log Page", lnvm_chunk_log)
> 
> Chunk Information Log Page ?

Sure, I'm fine with that also.

> >   		ENTRY("init", "Initialize media manager on LightNVM device", lnvm_init)
> >   		ENTRY("create", "Create target on top of a LightNVM device", lnvm_create_tgt)
> >   		ENTRY("remove", "Remove target from device", lnvm_remove_tgt)
> 
> Hi Minwoo,
> 
> Could you squash patch 2, 3 and 4 together (4 being the main patch) - They
> belong together to implement one feature.
> 
> As a side-note, we have the same command for ZNS (that will be pushed when
> the ZNS TP is ratified) - In that, we've also added support for supplying
> start lba and number of chunks (zones) to return. Could you add that as well
> to this? Then there is coherency between the two?

Thanks for the review.  Yes I will if the TP has been ratified.  Also
I'll prepare a new series with squashed what you just mentioned here :)

Thanks!
