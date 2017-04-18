From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 18 Apr 2017 19:35:13 +0800
Subject: [PATCH V2] nvme: make use of nvme error status codes in block
 layer
In-Reply-To: <20170418080854.GA21059@infradead.org>
References: <1492434939-12308-1-git-send-email-guanjunxiong@huawei.com>
 <20170418080854.GA21059@infradead.org>
Message-ID: <d28d14b3-7627-7490-8312-09ecae3addef@huawei.com>



On 2017/4/18 16:08, Christoph Hellwig wrote:
> NAK.  Please don't start exposing random error codes to the block
> layer.  There are a few (very few) with special meaning in the block
> layer, mostly just for multipathing.  If you have an actual,
> demonstrated need for those we can add it.  Otherwise you're just
> creating noise.
> 
> .
> 

Thanks for your reply which makes sense.  We really need to let dm-multipath
make use of the nvme error codes. Current all error codes are converted to EIO
except NVME_SC_CAP_EXCEEDED, which means almost IO are retried on other path.

If some nvme error codes such as NVME_SC_WRITE_FAULT,NVME_SC_READ_ERROR
into -ENODATA so that it will not retry to save bandwith. Does it make sense?
