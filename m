From: keith.busch@gmail.com (Keith Busch)
Date: Mon, 10 Jun 2019 10:00:30 -0600
Subject: [PATCH] PCI: Add Intel remapped NVMe device support
In-Reply-To: <20190610074456.2761-1-drake@endlessm.com>
References: <20190610074456.2761-1-drake@endlessm.com>
Message-ID: <CAOSXXT7OFzHeTxNqZ1sS6giRxhDcrUUnVjURWBiFUc5T_8p=MA@mail.gmail.com>

On Mon, Jun 10, 2019@1:45 AM Daniel Drake <drake@endlessm.com> wrote:
> +       /* We don't support sharing MSI interrupts between these devices */
> +       nrdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

And this is a problem, isn't it? Since we don't have an option to open
the MSI implementation in RAID mode, your experience will be much
better to disable this mode when using Linux as per the current
recommendation rather than limping along with legacy IRQ.
