From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jul 2018 12:04:36 -0700
Subject: host submit bi-directional buffer
In-Reply-To: <20180703141750.GD22877@localhost.localdomain>
References: <CAKoHnaH_2wZ4eO_K_t80LYENM2P8y-YLvddYcYyWy36+uHZw5g@mail.gmail.com>
 <20180703141750.GD22877@localhost.localdomain>
Message-ID: <20180708190436.GA17894@infradead.org>

On Tue, Jul 03, 2018@08:17:51AM -0600, Keith Busch wrote:
> The driver doesn't support bi-directional commands, but you may be able
> to get the same result if your user buffer is page aligned and you don't
> have an IOMMU enforcing read/write access.

I wouldn't rely on this, there is all kinds of reasons this can
go entirel wrong, including cache maintainance.

But given that NVMe does not actually specify bidirectional commands
no one could even know how they work, so I'm surprised the original
poster seems to have some..
