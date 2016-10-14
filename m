From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Oct 2016 11:57:22 -0400
Subject: NVMe U.2 Concurrent Maintenance - Identify LED
In-Reply-To: <OF6508F29F.5646743D-ON8625804C.0051E01E-8625804C.00552F15@notes.na.collabserv.com>
References: <OF6508F29F.5646743D-ON8625804C.0051E01E-8625804C.00552F15@notes.na.collabserv.com>
Message-ID: <20161014155722.GA19383@localhost.localdomain>

On Fri, Oct 14, 2016@10:30:26AM -0500, Murali N Iyer wrote:
> We were wondering how NVMe SSDs planned to be serviced in the field
> compared to the SATA/SAS. As far as I know typically there are two LEDs
> standard 2.5" (U.2) devices provide. One is a activity LED and the other is
> Identification/Fault LED. Activity LED is controlled by the device itself
> and no issues there. As far as Identify LED is concern it is typically
> controller by the device enclosure or the system enclosure services. As we
> know in case of SCSI/SAS there is a SCSI Enclosure Service (SES) that
> provides interface to control the ID/Fault LED.
> 
> I see some systems providing access to the NVMe SSD ID/Fault LED via out of
> band service provided by the service processor like BMC. Is there any
> inband mechanism defined by NVMe? I glanced through NVMe and NVMe
> Management Interface but couldn't find. Any insight is appreciated..

Currently it's platform/vendor specific.

There are multiple TPars under consideration in NVMe-MI that bring this
capabilitity in various way, but I'm not directly involved with any
of these.
