From: jsmart2021@gmail.com (James Smart)
Date: Tue, 23 May 2017 09:02:41 -0700
Subject: [PATCH v2 0/2] nvme_fc: add uevent to allow dynamic connects
In-Reply-To: <20170523071744.GA31698@infradead.org>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
 <20170523071744.GA31698@infradead.org>
Message-ID: <bd02e8e3-a505-e3fd-be93-c817cc345453@gmail.com>

On 5/23/2017 12:17 AM, Christoph Hellwig wrote:
> On Sat, May 13, 2017@12:05:57PM -0700, James Smart wrote:
>> These patches add support for generating a uevent which can be
>> caugth and converted to a nvme-cli connect-all request for the
>> FC initiator and target ports.
>
> Can you post the nvme-cli side as well so that it can be reviewed
> together?

See the patch description in Patch 2.  It has the udev event rule, which 
invokes nvme cli, that was used to test with.

-- james
