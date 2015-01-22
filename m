From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 18:47:11 +0000 (UTC)
Subject: [PATCH] NVMe: avoid kmalloc/kfree for smaller IO
In-Reply-To: <CANvN+emqnrm1YE2Ft68=Q+aMBgDUVEUhHUTfPwPM=yBX-EhtHg@mail.gmail.com>
References: <20150122043805.GA12546@kernel.dk>
 <alpine.LNX.2.00.1501221702170.15481@localhost.lm.intel.com>
 <CANvN+end4BQMAeBZKggbA8k+gjQzKj2xYx+=hovbTvmK_GH4Ug@mail.gmail.com>
 <alpine.LNX.2.00.1501221823430.15481@localhost.lm.intel.com>
 <CANvN+emqnrm1YE2Ft68=Q+aMBgDUVEUhHUTfPwPM=yBX-EhtHg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1501221840120.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Andrey Kuzmin wrote:
> On Jan 22, 2015 9:33 PM, "Keith Busch" <keith.busch@intel.com> wrote:
> > On Thu, 22 Jan 2015, Andrey Kuzmin wrote:
> >> AFAIR, per spec NVMe device operates in system page size terms.
> >
> > That's the ideal situation, but the device and system don't always have
> > the same capabilities. Pretty much every nvme controller supports 4k,
> > and for many, that's all they understand. Some archs use 8k pages, so
> 
> Doesn't this get negotiated at PCIe level?

It's initialized through NVMe controller registers during initialization
based on its reported capabilities and the system page size. This is
just informing the controller of the DMA alignment to use for its PRP
scatter-gather mechanism.
