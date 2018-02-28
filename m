From: marc@merlins.org (Marc MERLIN)
Date: Tue, 27 Feb 2018 18:22:37 -0800
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20171214033633.4oncj3kcsvxv4kic@merlins.org>
References: <20170313153319.fmy6ww72fjtx74xq@merlins.org>
 <20170313143649.GC6994@localhost.localdomain>
 <20170311022612.GB28220@merlins.org>
 <20170215181435.36saagrln25im7ml@merlins.org>
 <20171214033633.4oncj3kcsvxv4kic@merlins.org>
Message-ID: <20180228022237.jaywgrmojhlcqs4e@merlins.org>

On Wed, Dec 13, 2017@07:36:33PM -0800, Marc MERLIN wrote:
> So, I was all happy and all with 4.11, and it still works fine.
> S3 sleep just works, hibernate just works.
> And then 4.12 came, and S3 sleep would not work reliably
> 4.13 came, same thing
> 4.14, again, same thing :(
> 
> Currently when I put the laptop to sleep, it sometimes, but just
> sometimes, keeps the thinkpad light in a slow pulsing light as if it
> were still in sleep mode, and just never wakes up.
> 
> Sadly, this is crappy to bisect since it's not reliably reproducible.
> 
> Before I go through that pain, are there any suggestions or ideas I
> should try?

Well, this is kind of embarassing, but here's what happened.

I got tired of my laptop locking up when recovering from S3 sleep
(sometimes) with 4.12, and 100% of the time with 4.13 and above all the
way to 4.15.
So, I bought a 1TB Sata M2 drive to replace my NVME one.
I spent time setting it up, and then... it failed just like with NVME.

So, NVME was innocent.
A lot of trial and error later, I found out that the iwlagn driver
actually broke between 4.11 and 4.12/4.13 and causes hangs on S3 resume.
Sigh..
My suspend script now unloads the wireless driver before going to sleep,
and all is well again.

Sorry about the wrong report on NVME.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
