From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 3 May 2019 12:41:36 +0900
Subject: [PATCH 2/4] devcoredump: allow to create several coredump files
 in one device
In-Reply-To: <f0f772e5e33519dac93672be26fa7995f8109721.camel@sipsolutions.net>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-3-git-send-email-akinobu.mita@gmail.com>
 <f0f772e5e33519dac93672be26fa7995f8109721.camel@sipsolutions.net>
Message-ID: <CAC5umyhyVNA63OUQsw=SSP_poPOwQ+Y7sPRRpGLaJXb7T-C3Ug@mail.gmail.com>

2019?5?2?(?) 21:47 Johannes Berg <johannes at sipsolutions.net>:
>
> On Thu, 2019-05-02@17:59 +0900, Akinobu Mita wrote:
> >
> >  static void devcd_del(struct work_struct *wk)
> >  {
> >       struct devcd_entry *devcd;
> > +     int i;
> >
> >       devcd = container_of(wk, struct devcd_entry, del_wk.work);
> >
> > +     for (i = 0; i < devcd->num_files; i++) {
> > +             device_remove_bin_file(&devcd->devcd_dev,
> > +                                    &devcd->files[i].bin_attr);
> > +     }
>
> Not much value in the braces?

OK.  I tend to use braces where a single statement but multiple lines.

> > +static struct devcd_entry *devcd_alloc(struct dev_coredumpm_bulk_data *files,
> > +                                    int num_files, gfp_t gfp)
> > +{
> > +     struct devcd_entry *devcd;
> > +     int i;
> > +
> > +     devcd = kzalloc(sizeof(*devcd), gfp);
> > +     if (!devcd)
> > +             return NULL;
> > +
> > +     devcd->files = kcalloc(num_files, sizeof(devcd->files[0]), gfp);
> > +     if (!devcd->files) {
> > +             kfree(devcd);
> > +             return NULL;
> > +     }
> > +     devcd->num_files = num_files;
>
> IMHO it would be nicer to allocate all of this in one struct, i.e. have
>
> struct devcd_entry {
>         ...
>         struct devcd_file files[];
> }
>
> (and then use struct_size())

Sounds good.

> > @@ -309,7 +339,41 @@ void dev_coredumpm(struct device *dev, struct module *owner,
> >   put_module:
> >       module_put(owner);
> >   free:
> > -     free(data);
> > +     for (i = 0; i < num_files; i++)
> > +             files[i].free(files[i].data);
> > +}
>
> and then you don't need to do all this kind of thing to free
>
> Otherwise looks fine. I'd worry a bit that existing userspace will only
> capture the 'data' file, rather than a tarball of all files, but I guess
> that's something you'd have to work out then when actually desiring to
> use multiple files.

Your worrying is correct.  I'm going to create a empty 'data' file for nvme
coredump.  Assuming that devcd* always contains the 'data' file at least,
we can simply write to 'data' when the device coredump is no longer needed,
and prepare for the newer coredump.
