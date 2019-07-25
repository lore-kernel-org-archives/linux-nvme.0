From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 13:14:40 -0600
Subject: [PATCH 06/14] PCI/P2PDMA: Add whitelist support for Intel Host
 Bridges
In-Reply-To: <20190725185230.GG7450@mellanox.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-7-logang@deltatee.com>
 <20190725185230.GG7450@mellanox.com>
Message-ID: <dc151716-d584-35df-0de6-d25c1267be6c@deltatee.com>



On 2019-07-25 12:52 p.m., Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019@05:08:51PM -0600, Logan Gunthorpe wrote:
>> Intel devices do not have good support for P2P requests that span
>> different host bridges as the transactions will cross the QPI/UPI bus
>> and this does not perform well.
>>
>> Therefore, enable support for these devices only if the host bridges
>> match.
>>
>> Adds the Intel device's that have been tested to work. There are
>> likely many others out there that will need to be tested and added.
>>
>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
>>  drivers/pci/p2pdma.c | 36 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index dfb802afc8ca..143e11d2a5c3 100644
>> +++ b/drivers/pci/p2pdma.c
>> @@ -250,9 +250,28 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>>  }
>>  
>> -static bool __host_bridge_whitelist(struct pci_host_bridge *host)
>> +static const struct pci_p2pdma_whitelist_entry {
>> +	unsigned short vendor;
>> +	unsigned short device;
>> +	bool req_same_host_bridge;
> 
> This would be more readable in the initializer as a flags not a bool

Ok, will change for v2.

Logan
