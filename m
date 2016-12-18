From: logang@deltatee.com (Logan Gunthorpe)
Date: Sun, 18 Dec 2016 10:20:47 -0700
Subject: [RFC 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <20161218075141.GE29850@kroah.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
 <20161218075141.GE29850@kroah.com>
Message-ID: <d7c26e15-34f3-26d4-e13a-f24b4a9034c3@deltatee.com>

Hi Greg,

Thanks for the quick review!

On 18/12/16 12:51 AM, Greg Kroah-Hartman wrote:
> On Sat, Dec 17, 2016@10:09:22AM -0700, Logan Gunthorpe wrote:
>> +struct switchtec_dev {
>> +	struct pci_dev *pdev;
>> +	struct msix_entry *msix;
>> +	struct device *dev;
>> +	struct kref kref;
>
> Why do you have a pointer to a device, yet a kref as well?  Just have
> this structure embed a 'struct device' in itself, like you did for a
> kref, and you will be fine.  Otherwise you are dealing with two
> different sets of reference counting here, for no good reason.

Ok, understood. I had referenced the device dax driver which did it this 
way in 4.8 but looks like it was changed to the way you suggest in 4.9.

>> +#define stdev_pdev(stdev) ((stdev)->pdev)
>> +#define stdev_pdev_dev(stdev) (&stdev_pdev(stdev)->dev)
>> +#define stdev_name(stdev) pci_name(stdev_pdev(stdev))
>> +#define stdev_dev(stdev) ((stdev)->dev)
>
> Ick, just open code these please.  That's a huge hint your use of the
> driver model is not correct :)

Ok, will do. For reference, I was copying

drivers/ntb/hw/intel/ntb_hw_intel.h

which does a similar thing.

Logan
