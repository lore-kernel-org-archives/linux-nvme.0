From: zhangweiping@didichuxing.com (weiping zhang)
Date: Mon, 10 Jul 2017 16:02:23 +0800
Subject: [PATCH] nvme-pci: add module parameter for io queue depth
In-Reply-To: <dabfe11a-d133-4de9-4be5-b1b8e0c63e87@grimberg.me>
References: <20170707090547.GA2420@localhost.didichuxing.com>
 <20170707152948.GB14788@localhost.localdomain>
 <dabfe11a-d133-4de9-4be5-b1b8e0c63e87@grimberg.me>
Message-ID: <20170710080223.GA5323@localhost.didichuxing.com>

On Mon, Jul 10, 2017@08:54:57AM +0300, Sagi Grimberg wrote:
> 
> >>+static int io_queue_depth = 1024;
> >>+module_param(io_queue_depth, int, 0644);
> >>+MODULE_PARM_DESC(io_queue_depth, "set io queue depth");
> >We need to be a little more careful about this field if users can write
> >whatever they want. It's gotta be >= 2 or else trouble will occur.
> 
> Agreed, please resend the patch. Perhaps a good way is to use
> module_param_cb() to verify the input value is >= 2?

thanks so much, I will send patch v3.
