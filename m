From: kashyap.desai@broadcom.com (Kashyap Desai)
Date: Fri, 14 Jun 2019 01:34:00 +0530
Subject: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi
 host
In-Reply-To: <20190613084458.GB13221@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
 <20190613084458.GB13221@lst.de>
Message-ID: <d411baa1bdd34f1a1289480d13fe1cef@mail.gmail.com>

>
> So before I respin this series, can you help with a way to figure out
for
> mpt3sas and megaraid if a given controller supports NVMe devices at all,
so
> that we don't have to set the virt boundary if not?


In MegaRaid we have below enum -        VENTURA_SERIES and AERO_SERIES
supports NVME

enum MR_ADAPTER_TYPE {
        MFI_SERIES = 1,
        THUNDERBOLT_SERIES = 2,
        INVADER_SERIES = 3,
        VENTURA_SERIES = 4,
        AERO_SERIES = 5,
};

In mpt3sas driver we have below method - If IOC FACT reports NVME Device
support in Protocol Flags, we can consider it as HBA with NVME drive
support.

ioc->facts.ProtocolFlags & MPI2_IOCFACTS_PROTOCOL_NVME_DEVICES

Kashyap
