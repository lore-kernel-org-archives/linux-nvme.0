From: kbusch@kernel.org (Keith Busch)
Date: Fri, 17 May 2019 12:36:14 -0600
Subject: [PATCH v2] nvme: fix memory leak for power latency tolerance req
In-Reply-To: <0becf386-c4f5-b0f9-2d5f-84da0e58226c@redhat.com>
References: <20190517023007.140656-1-yuyufen@huawei.com>
 <0becf386-c4f5-b0f9-2d5f-84da0e58226c@redhat.com>
Message-ID: <20190517183614.GB25092@localhost.localdomain>

On Fri, May 17, 2019@05:22:48AM -0700, David Milburn wrote:
> On 05/16/2019 09:30 PM, Yufen Yu wrote:
> >   void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> >   {
> > +	dev_pm_qos_hide_latency_tolerance(ctrl->device);
> >   	cdev_device_del(&ctrl->cdev, ctrl->device);
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
> > 
> 
> This one works too. Thanks
> 
> Tested-by: David Milburn <dmilburn at redhat.com>

Thanks, applied for 5.2
