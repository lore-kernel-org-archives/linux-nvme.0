From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 9 May 2019 00:40:14 +0900
Subject: [PATCH v2 3/7] devcoredump: allow to create several coredump
 files in one device
In-Reply-To: <aced1953-4ea2-c8b1-9ee9-068e92ae1f8a@intel.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-4-git-send-email-akinobu.mita@gmail.com>
 <aced1953-4ea2-c8b1-9ee9-068e92ae1f8a@intel.com>
Message-ID: <CAC5umyiLgyGambM+umb3GoYV-0Eo-CFiyy5RLhKGTq+fBTcZtQ@mail.gmail.com>

2019?5?8?(?) 2:35 Heitke, Kenneth <kenneth.heitke at intel.com>:
>
>
>
> On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > @@ -292,6 +309,12 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >       if (device_add(&devcd->devcd_dev))
> >               goto put_device;
> >
> > +     for (i = 0; i < devcd->num_files; i++) {
> > +             if (device_create_bin_file(&devcd->devcd_dev,
> > +                                        &devcd->files[i].bin_attr))
> > +                     /* nothing - some files will be missing */;
>
> Is the conditional necessary if you aren't going to do anything?

The device_create_bin_file() is declared with __must_check, so ignoring
the return value emits warning.
