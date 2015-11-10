From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Tue, 10 Nov 2015 22:34:59 +0100
Subject: nvme: controller resets
In-Reply-To: <CAKajsGMkdckHbYyb8XY=ByYsHF0=-cNA2o5RnTN0XKVSopyiDQ@mail.gmail.com>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <3dda89a86dbd6c8ede4057884c43170c@localhost>
 <CAKajsGMkdckHbYyb8XY=ByYsHF0=-cNA2o5RnTN0XKVSopyiDQ@mail.gmail.com>
Message-ID: <3736f57d17ee808526a8f35bb4c50eea@localhost>

On 2015/November/11 02:46, Vedant Lath wrote:
> I tried nvme-cli to get the error log but that was empty.

dito.

> Could you please check if the firmware version of your SSD is the same
> as mine? I have posted details given by nvme-cli at
> http://pastebin.ubuntu.com/13049434/ .

Mine:

| NVME Identify Controller:
| vid     : 0x106b
| ssvid   : 0x106b
| sn      : C025xxxxxxxxxxxxxx
| mn      : APPLE SSD AP0512H
| fr      : 5.841.01

I have reports of other guys with firmware 5.831.01 and 5.844.01. Both 
have the same problems.

Are using a MacBook8,1 oder MacBook7,1?
