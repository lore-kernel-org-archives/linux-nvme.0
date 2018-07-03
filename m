From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 3 Jul 2018 08:17:51 -0600
Subject: host submit bi-directional buffer
In-Reply-To: <CAKoHnaH_2wZ4eO_K_t80LYENM2P8y-YLvddYcYyWy36+uHZw5g@mail.gmail.com>
References: <CAKoHnaH_2wZ4eO_K_t80LYENM2P8y-YLvddYcYyWy36+uHZw5g@mail.gmail.com>
Message-ID: <20180703141750.GD22877@localhost.localdomain>

On Tue, Jul 03, 2018@06:34:06AM +0300, dani maoz wrote:
> Hi
> I added a new command vendor specific to core.c (host).
> I would like the buffer to bi-directional and send a read command to
> my device, but the device should read the content of the buffer before
> update it with new data.
> I update the function nvme_alloc_request, so the direction would be like write.
> the device was able to read the buffer It's seems the device write the
> new information on PCI bus, but the buffer in the host hasn't change
> (NVME transaction success, used nvme-cli),
> What is the lower layer the buffer is copied?
> Should I also update block also the block a layer,  ?
> Is there a reason to declare the buffer read or write but not bi-directional?
> kernel 4.18_rc1
> Thanks in advance

The driver doesn't support bi-directional commands, but you may be able
to get the same result if your user buffer is page aligned and you don't
have an IOMMU enforcing read/write access.
