From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 8 Nov 2017 09:40:10 +0800
Subject: [PATCHv3 5/5] nvme: Send uevent for some asynchronous events
In-Reply-To: <20171107221314.27822-6-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-6-keith.busch@intel.com>
Message-ID: <66c2e71a-a74f-54c0-8cba-b5f13bd0b5c4@huawei.com>


Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>

On 2017/11/8 6:13, Keith Busch wrote:
> This will give udev a chance to observe and handle asynchronous event
> notifications and clear the log to unmask future events of the same type.
> The driver will create a change uevent of the asyncronuos event result
> before submitting the next AEN request to the device if a completed AEN
> event is of type error, smart, command set or vendor specific,
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
