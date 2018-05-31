From: hch@lst.de (hch@lst.de)
Date: Thu, 31 May 2018 19:00:09 +0200
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
Message-ID: <20180531170009.GA31715@lst.de>

On Tue, May 29, 2018@08:23:09PM +0000, Ruhl, Michael J wrote:
> I can see that the 2 and 20 are defined for specific things.  Since they are
> used in several places (in the next 2 patches), is there any chance these
> could be defined bits?

So far our rule of thumb was to use defines where the NVMe spec
defines symbolic names, and use plain bit numbers where the spec
does the same.  The SGLS field falls into the latter category.

If we end up with a lot of users a little helper function might be
nice, but I don't think we aren't there yet.
