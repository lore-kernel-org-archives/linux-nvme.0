From: keith.busch@intel.com (Keith Busch)
Date: Tue, 3 Oct 2017 08:25:15 -0600
Subject: Bug report: ref tag error while running IO > MDTS on nvme device
In-Reply-To: <25030a78-f59b-a9de-b570-e9e05c9f4411@mellanox.com>
References: <25030a78-f59b-a9de-b570-e9e05c9f4411@mellanox.com>
Message-ID: <20171003142515.GA16678@localhost.localdomain>

Hi Max,

Is this behavior new, or was this always broken?

Since you mention MDTS, I wonder if this device is counting the separate
metadata as part of the transfer and doing the wrong thing as a result?
We're only supposed to count the metadata size in consideration of MDTS
if metadata is interleaved.

On Tue, Oct 03, 2017@12:48:34PM +0300, Max Gurtovoy wrote:
> Hi guys,
> I would like to report a bug while running fio on local nvme device (SAMSUNG
> MZPLL1T6HEHP-00003) that was formated to use integrity:
> 
> nvme format /dev/nvme2n1 -n 1 -l 1 -i 2 -p 0 -m 0
> nvme id-ns /dev/nvme2n1:
> 
> NVME Identify Namespace 1:
> nsze    : 0xba4d4ab0
> ncap    : 0xba4d4ab0
> nuse    : 0xba4d4ab0
> nsfeat  : 0
> nlbaf   : 3
> flbas   : 0x1
> mc      : 0x3
> dpc     : 0x1f
> dps     : 0x2
> nmic    : 0x1
> rescap  : 0x7f
> fpi     : 0x80
> nawun   : 0
> nawupf  : 0
> nacwu   : 0
> nabsn   : 0
> nabo    : 0
> nabspf  : 0
> noiob   : 0
> nvmcap  : 1600321314816
> nguid   : 334842304a6000840025384100000002
> eui64   : 002538e671000457
> lbaf  0 : ms:0   lbads:9  rp:0x1
> lbaf  1 : ms:8   lbads:9  rp:0x3 (in use)
> lbaf  2 : ms:0   lbads:12 rp:0
> lbaf  3 : ms:8   lbads:12 rp:0x2
> 
> running traffic up to IO size <= 128KB works fine but running bigger IO that
> the MDTS caused many ref tag errors (for example):
> 
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 324043008
> (rcvd 0)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2929058096
> (rcvd 1241579520)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2292844816
> (rcvd 2483027968)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2523145472
> (rcvd 243859455)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 1177656832
> (rcvd 15400959)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 187312640
> (rcvd 243859455)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2344798720
> (rcvd 126418943)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2892037376
> (rcvd 126418943)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2292845056
> (rcvd 143196159)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 1237630256
> (rcvd 1241579520)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 1237630208
> (rcvd 143196159)
> [Tue Oct  3 12:34:25 2017] nvme2n1: ref tag error at location 2986034432
> (rcvd 243859455)
> [Tue Oct  3 12:34:45 2017] nvme2n1: ref tag error at location 881629440
> (rcvd 15400959)
> [Tue Oct  3 12:34:45 2017] nvme2n1: ref tag error at location 1889589504
> (rcvd 243859455)
> [Tue Oct  3 12:34:45 2017] nvme2n1: ref tag error at location 1889589504
> (rcvd 243859455)
> 
> haven't debugged it yet, but if anyone has an idea for the root cause, it
> would be great.
