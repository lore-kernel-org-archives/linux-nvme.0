From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 23 May 2019 00:23:38 +0900
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
In-Reply-To: <44154394-c0a0-4895-d406-ea357a906cfe@intel.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <44154394-c0a0-4895-d406-ea357a906cfe@intel.com>
Message-ID: <CAC5umyghtb58HB08PPZsds5Kf82wr3jq0HPG4861_9JS7KF4gw@mail.gmail.com>

2019?5?22?(?) 6:05 Heitke, Kenneth <kenneth.heitke at intel.com>:
>
>
>
> On 5/21/2019 10:04 AM, Akinobu Mita wrote:
> > +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> > +                                  unsigned int sensor, int temp)
> > +{
> > +     unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> > +     int status;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> > +             return -EINVAL;
> > +
> > +     if (temp > NVME_TEMP_THRESH_MASK)
> > +             return -EINVAL;
> > +
> > +     threshold |= temp & NVME_TEMP_THRESH_MASK;
> > +
> > +     ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> > +                             &status);
>
> I'm not sure about best practices here but since 'status' is unused, you
> can pass in a NULL pointer. The called function deals with it correctly.

OK.  Make sense.
