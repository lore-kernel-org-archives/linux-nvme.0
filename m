From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Tue, 24 Jan 2017 19:20:05 +0000
Subject: crash in sg_alloc_table_chained
In-Reply-To: <20170124074756.GB27932@infradead.org>
References: <8C8F83F9-BDBB-4B59-BA4E-BAA34CB2E20D@cavium.com>
 <20170124074756.GB27932@infradead.org>
Message-ID: <25B54EB5-D9FC-426E-95F0-55021EC880BB@cavium.com>

Thanks Christoph.  That patch worked.  



Darren Trapp
Senior Director - Engineering
darren.trapp at cavium.com <mailto:darren.trapp at caviumnetworks.com>
T 949-389-6273
M 949-212-8576
26650 Aliso Viejo Pkwy, Aliso Viejo, CA 92656
www.qlogic.com <http://www.qlogic.com/>
 <http://www.qlogic.com/>

On 1/23/17, 11:47 PM, "Christoph Hellwig" <hch@infradead.org> wrote:

    Hi Darren,
    
    you probably want this patch that I sent last week:
    
       "Subject: [PATCH] nvme-fc: use blk_rq_nr_phys_segments"
    
