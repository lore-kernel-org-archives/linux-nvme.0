From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 7 May 2018 10:08:53 -0600
Subject: PCIe unsupported request with Intel 760p
In-Reply-To: <20180507155759.GA13397@gmail.com>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
 <20180507134354.GF18116@bombadil.infradead.org>
 <20180507151246.GB20686@localhost.localdomain>
 <20180507155759.GA13397@gmail.com>
Message-ID: <20180507160853.GF20686@localhost.localdomain>

On Mon, May 07, 2018@11:57:59AM -0400, Aron Griffis wrote:
> Keith Busch wrote:  [Mon May 07 2018, 11:12:47AM EDT]
> > Aron,
> > Could you let me know the firmware revision you're currently running?
> 
> Hi Keith, is this what you need?
> 
> $ sudo nvme list
> Node             SN                   Model                                    Namespace Usage                      Format           FW Rev
> ---------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
> /dev/nvme0n1     BTHH807007N4512D     INTEL SSDPEKKW512G8                      1         512.11  GB / 512.11  GB    512   B +  0 B   001C

Thank you, that's what I needed. That appears to be the latest released
firmware for this device. I'll let you know as soon as I find more
information.
