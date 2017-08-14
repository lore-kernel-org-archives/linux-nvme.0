From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 14 Aug 2017 14:16:49 +0000
Subject: [PATCH v2 1/2] nvmet_fc: add defer_req callback for deferment of
 cmd buffer return
References: <20170805002933.23397-1-jsmart2021@gmail.com>
 <20170805002933.23397-2-jsmart2021@gmail.com>
Message-ID: <CY1PR0401MB15363E9796381A376013E71C988C0@CY1PR0401MB1536.namprd04.prod.outlook.com>

On 08/04/17 17:29, James Smart wrote:
> +	/* Cleanup defer'ed IOs in queue */
> +	list_for_each_entry(deferfcp, &queue->avail_defer_list, req_list) {
> +		list_del(&deferfcp->req_list);
> +		kfree(deferfcp);
> +	}

Hello James,

Coverity reports a user-after-free for the above code:

*** CID 1416424:  Memory - illegal accesses  (USE_AFTER_FREE)
/drivers/nvme/target/fc.c: 738 in nvmet_fc_delete_target_queue()
732     					&tgtport->fc_target_port, fod->fcpreq);
733     			}
734     		}
735     	}
736     
737     	/* Cleanup defer'ed IOs in queue */
>>>     CID 1416424:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>     Dereferencing freed pointer "deferfcp".
738     	list_for_each_entry(deferfcp, &queue->avail_defer_list, req_list) {
739     		list_del(&deferfcp->req_list);
740     		kfree(deferfcp);
741     	}
742     
743     	for (;;) {
