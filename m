From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 1 Aug 2017 08:29:00 +0000
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>,
 <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
Message-ID: <MWHPR04MB1008D3259D1E7EDB5BAC0FDD86B30@MWHPR04MB1008.namprd04.prod.outlook.com>

HI Sagi,

Please see my inline comments.


From: Sagi Grimberg <sagi@grimberg.me>
Sent: Sunday, July 30, 2017 11:45 PM
To: Chaitanya Kulkarni; linux-nvme at lists.infradead.org
Subject: Re: [PATCH V3] nvme-pci: add sgl support
?   
Chaitanya,

> In order to enable SGL mode for the driver, the user can set the
> sgl_threshold module parameter. This parameter can be used
> in the two modes:-
> 
> 1. Allow all IOs to use SGL mode. (set sgl_threshold to 1).
> 2. Set up the IO size threshold to determine whether to use
>????? SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
>????? use SGL only for IOs which are >= 4096 in the size).

The fact that you introduce a sgl_threshold implies that prps
are better than sgls for small I/O sizes, are sgls better
than prps to large I/O size?

[CK] Yes, I've observed approximately %5 better
performance for IO sizes larger than 32k (for sgl_threshold = 32k).

I think it would be better to maintain a fallback mechanism instead of a
threshold modparam. My main problem with this is that it looks like we
cannot handle payloads smaller than sgl_threshold which are not
prp-able.

What if we always try to prp a request, but if we fail and the device
supports SGLs (it must, because we got a non-prp-able payload) we create
a sgl for it. For small block size the fallback is cheap and for large
I/Os the fallback is small compared to the device latency. This way we
can handle any bio_vec payload coming down at us.

[CK] In current SGL (V3 nvme : add sgl support) implementation we try to
keep code paths identical for both PRPs and SGLs so that either of the
modes will not have any effect on another one.
By prioritizing the PRPs over SGLs it kind a defeats the purpose. 

Is it possible to keep the initial implementation simple with proper
documentation (by maintaining the identical code paths for
SGLs and PRPS)?

In case if we still want to have the support for handling any payload we
can do something like this (on the top of latest SGL patch) :-

Current implementation  :-

if (nvme_pci_use_sgls(dev, req)) {
	ret = nvme_setup_sgls(dev, req, &cmnd->rw);
	if (ret != BLK_STS_OK)
		goto out_unmap;
} else {
	ret = nvme_setup_prps(dev, req, &cmnd->rw);
	if (ret != BLK_STS_OK)
		goto out_unmap;
}

SGLs fallback mechanism for PRPs to handle any payload independent of
sgl_threshold :- 

if (nvme_pci_use_sgls(dev, req)) {
	ret = nvme_setup_sgls(dev, req, &cmnd->rw);
	if (ret != BLK_STS_OK)
		goto out_unmap;
} else {
	ret = nvme_setup_prps(dev, req, &cmnd->rw);
	/* handle the non PRP-able payloads smallers than the sgl_threshold */
	if (ret != BLK_STS_OK) {
		int out = 0;
		/* 
		 * For fallback mechanism we need to setup the sgls irrespective
                 * of sgl_threhold value.
                 */
		if (dev->ctrl.sgls & NVME_CTRL_SUPP_SGL)) {
			ret = nvme_setup_sgls(dev, req, &cmnd->rw);
			if (ret != BLK_STS_OK)
				out = 1;
		} else
			out = 1;
		
		if (out)
			goto out_unmap;
	}
}

In the future, we can mark a bio with gappy payload and we can just
rely on that instead of the fallback instead of deprecating a modparam.

[CK] Agree, I think the addition of the gappy payload flag in conjunction
with virt_boundary mask is the right way to implement SGLs support in
the IO stack and it will give NVMe PCI driver more control over the
choice of SGLs or PRPs dynamically.

My experience from threshold modparams, is that their not really used
efficiently outside the test case of the author.

[CK] But you think in this particular case application will have an ability
to toggle between different IO modes if the controller is supporting SGLs?
Also, we added threshold parameter to make the first implementation
simpler. I think gappy payload flag will help to make it better.

Thoughts?
   
