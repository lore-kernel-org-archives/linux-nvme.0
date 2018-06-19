From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 17:09:27 +0300
Subject: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180611184630.3435-1-jthumshirn@suse.de>
References: <20180611184630.3435-1-jthumshirn@suse.de>
Message-ID: <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>



On 06/11/2018 09:46 PM, Johannes Thumshirn wrote:
> Add disk name to tracepoints so we can better distinguish between
> individual disks in the trace output.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> ---
> 
> I'm not entirely sure if this adding the ctrl pointers to
> nvme_complete_rq() and nvme_setup_cmd() is a good idea, it's the
> fast-path after all.

We are going to need it for traffic based keep alive to update
that we saw a completion to extend the kato.

But I suggest you simply keep a ctrl reference in struct nvme_request
instead so you don't need to pass it to nvme_complete_req (that's what
I did for traffic based keep alive).
