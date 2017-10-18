From: drake@endlessm.com (Daniel Drake)
Date: Wed, 18 Oct 2017 11:01:33 +0800
Subject: AHCI NVMe remap update
Message-ID: <CAD8Lp450TSnpzTAGiAgKjJws6VnVu9ZWv_x-GFQ5RhNOTnNCpQ@mail.gmail.com>

Hi Dan,

Thanks for the patches you posted last year at:
  http://lists.infradead.org/pipermail/linux-nvme/2016-October/006800.html
  [PATCH 0/5] ahci: nvme remap support

Looks like these patches stalled because of a lack of clarity of how
the device operates. Has there been any movement since then?

The issue became less critical soon after when Lenovo published a BIOS
update for affected models allowing the user to go into the BIOS and
disable RAID mode - it looked like it might have been a one off
headache for some models.

However it appears that Lenovo's newer models are still coming with
the RAID mode by default (we have seen this on Yoga 720), and asking
ordinary users to go into the BIOS, disable RAID and lose access to
their Windows install is not always a feasible option (we're trying to
support dual boot here).

Would be great if you could take another look at this.

Thanks
Daniel
