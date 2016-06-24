From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 01:00:44 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <576CE504.5020101@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160624073728.GA30277@infradead.org>
 <576CE504.5020101@jbeekman.nl>
Message-ID: <20160624080044.GA17446@infradead.org>

On Fri, Jun 24, 2016@12:45:08AM -0700, Jethro Beekman wrote:
> As you found NVMe points to SPC-4. SPC-4 lists protocol 0xEF "ATA Device Server
> Password Security" as part of the SECURITY PROTOCOL IN command, pointing to
> SAT-2. In one SAT-2 draft I could find there is are these sections
> 
>   12 SAT-specific SCSI extensions
>   12.5 SAT-specific Security Protocols
>   12.5.1 ATA Device Server Password Security Protocol
> 
> which provide a pretty straightforward translation of the ATA SECURITY feature
> set (except that there is a new command to gather information that would
> normally be part of ATA IDENTIFY). I have implemented all this and it seems to
> work on my drive.

Oh, fun.  Can you add a little file in Documentation that explains this
chain and how we end up building the NVMe commands?
