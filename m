From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 16 May 2019 23:35:55 +0900
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <CAC5umygg7BPhyoKsBDPAoafXHmJnqE1gEarafJDRCrdUnw-3aA@mail.gmail.com>

2019?5?16?(?) 0:17 Akinobu Mita <akinobu.mita at gmail.com>:
>
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 through
> temperature sensor 8).
> The temperature threshold feature (Feature Identifier 04h) configures the
> asynchronous event request command to complete when the temperature is
> crossed its correspoinding temperature threshold.
>
> This adds infrastructure to provide these temperatures and thresholds via
> thermal zone devices.
>
> The nvme_thermal_zones_register() creates up to nine thermal zone devices
> for valid temperature sensors including composite temperature.
>
> /sys/class/thermal/thermal_zone[0-*]:
>     |---temp: Temperature
>     |---trip_point_0_temp: Over temperature threshold
>     |---trip_point_0_hyst: Under temperature threshold

I misunderstood the under temperature threshold.  It is not hysteresis
for the upper temperature threshold.  It is used to notify cold temperature
that the device may not correctly work.

So we should provide another trip point for under temperature threshold,
but there is no suitable thermal trip type for cold temperature.

I'm going to remove trip_point_0_hyst and not utilize the under temperature
threshold.
