From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 10 Aug 2019 22:28:39 -0700
Subject: [PATCH v3 7/7] nvme: don't remove namespace if revalidate failed
 because of a transport error
In-Reply-To: <16b63247-f020-5522-ffab-9404ba7b3408@suse.de>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-8-sagi@grimberg.me>
 <16b63247-f020-5522-ffab-9404ba7b3408@suse.de>
Message-ID: <da217f10-97de-2eae-4e60-92ff84fb8014@grimberg.me>


> This is a neat solution, yet I'm not convinced that it'll solve the 
> problem entirely. I'll give it a spin.

Thanks Hannes,

Note that with tcp/rdma, there is another patch needed to pass
this test.

See:
[PATCH rfc] nvme: make all fabrics command run on a separate request queue

The reason is, that because we have admin commands making their way
to the target between we disable the controller and (re)enable it
as part of the reset process. Because of that, we have the target
failing some of the scan commands that are wrongly made it through
(which cause the scan work to wrongly remove the ns and hang).

So I would recommend running it with that patch as well (and also
get your feedback on it ;))
