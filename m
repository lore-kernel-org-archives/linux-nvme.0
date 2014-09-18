From: ashishkumarb@gmail.com (Ash B)
Date: Thu, 18 Sep 2014 14:35:51 -0700
Subject: Dataset management command
Message-ID: <CALhzMBQkahA7WxKSdeX1EyM5g-0HvtbicMyJfA0pyhnhZHWmtg@mail.gmail.com>

Hi,
I see Dataset management command in the spec; however, only deallocate has
been implemented and that to via discard flag in bio which is only for one
range. I'd like to understand how the community plans to implement other
DSM commands? Is it going to be via IOCTL or do we plan to add new flags in
bio?
Appreciate your insight.

Thanks
Ash
