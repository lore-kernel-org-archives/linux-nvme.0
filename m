From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 31 Jul 2017 09:45:37 +0300
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
Message-ID: <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>

Chaitanya,

> In order to enable SGL mode for the driver, the user can set the
> sgl_threshold module parameter. This parameter can be used
> in the two modes:-
> 
> 1. Allow all IOs to use SGL mode. (set sgl_threshold to 1).
> 2. Set up the IO size threshold to determine whether to use
>      SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
>      use SGL only for IOs which are >= 4096 in the size).

The fact that you introduce a sgl_threshold implies that prps
are better than sgls for small I/O sizes, are sgls better
than prps to large I/O size?

I think it would be better to maintain a fallback mechanism instead of a
threshold modparam. My main problem with this is that it looks like we
cannot handle payloads smaller than sgl_threshold which are not
prp-able.

What if we always try to prp a request, but if we fail and the device
supports SGLs (it must, because we got a non-prp-able payload) we create
a sgl for it. For small block size the fallback is cheap and for large
I/Os the fallback is small compared to the device latency. This way we
can handle any bio_vec payload coming down at us.

In the future, we can mark a bio with gappy payload and we can just
rely on that instead of the fallback instead of deprecating a modparam.

My experience from threshold modparams, is that their not really used
efficiently outside the test case of the author.

Thoughts?
