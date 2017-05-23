From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 23 May 2017 00:17:05 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
Message-ID: <20170523071705.GD16776@infradead.org>

On Mon, May 22, 2017@05:04:15PM +0800, Kai-Heng Feng wrote:
> Hi Andy,
> 
> Currently, if a power state tradition requires high latency, it may be
> skipped [1] based on the value of ps_max_latency_us in
> nvme_configure_apst():
> 
> if (total_latency_us > ctrl->ps_max_latency_us)
>     continue;
> 
> Right now ps_max_latency_us defaults to 25000, but some consumer level
> NVMe have much higher latency.
> I understand this value is configurable, but I am wondering if it's
> possible to ignore the latency on consumer devices, probably based on
> chassis type, so consumer devices can get most NVMe power saving out
> of the box?

What is your proposed change?  Do you have any numbers on how this
improves power consumption for given workloads and what the performance
impact is on common benchmarks?
