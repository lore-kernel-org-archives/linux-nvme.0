From: sunad.s@samsung.com (Sunad Bhandary)
Date: Mon, 30 May 2016 16:15:41 +0530
Subject: [PATCHv2] NVMe: Fix removal in case of active namespace list
 scanning method
In-Reply-To: <20160527132834.GA19990@localhost.localdomain>
References: <20160527132834.GA19990@localhost.localdomain>
Message-ID: <574C19D5.1060106@samsung.com>

>We don't want to remove the namespaces on error here. That could
>remove valid, in use namespaces: if nvme_identify_ns_list fails (maybe
>controller just doesn't support that identify mode), we do the
>sequential scanning.

>Just leave the 'goto free' alone, and call
>nvme_remove_invalid_namespaces only on success.

In the patch, the namespaces are not removed on failure of identify
list. If nvme_identify_ns_list fails, the value is returned and
sequential scanning is done. The call to nvme_remove_invalid_namespaces 
is done when the value of nsid in the list is 0.

Snapshot of patch:
  ....
	ret = nvme_identify_ns_list(ctrl, prev, ns_list);
                 if (ret)
                         goto free;
  ....
  	nsid = le32_to_cpu(ns_list[j]);
                         if (!nsid)
                                 goto out;
  ....

  out:
         nvme_remove_invalid_namespaces(ctrl, prev);
  free:
         kfree(ns_list);
         return ret;

This should be able to handle error scenarios or am I missing something?

Thanks and Regards,
Sunad
