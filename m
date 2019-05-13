From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 14 May 2019 00:01:07 +0900
Subject: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
In-Reply-To: <20190513135031.GC15318@localhost.localdomain>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
 <20190513135031.GC15318@localhost.localdomain>
Message-ID: <CAC5umyhT1MW_d8wjFj2qBaf1+j0b62yP_OzuGUbnV+_tnpkrEw@mail.gmail.com>

2019?5?13?(?) 22:55 Keith Busch <kbusch at kernel.org>:
>
> On Sun, May 12, 2019@08:54:15AM -0700, Akinobu Mita wrote:
> > +static void nvme_coredump_logs(struct nvme_dev *dev)
> > +{
> > +     struct dev_coredumpm_bulk_data *bulk_data;
> > +
> > +     if (!dev->dumps)
> > +             return;
> > +
> > +     bulk_data = nvme_coredump_alloc(dev, 1);
> > +     if (!bulk_data)
> > +             return;
> > +
> > +     if (nvme_coredump_telemetry_log(bulk_data, &dev->ctrl))
> > +             dev->num_dumps--;
> > +}
>
> You'll need this function to return the same 'int' value from
> nvme_coredump_telemetry_log. A negative value here means that the
> device didn't produce a response, and that's important to check from
> the reset work since you'll need to abort the reset if that happens.

OK.  Make sense.
