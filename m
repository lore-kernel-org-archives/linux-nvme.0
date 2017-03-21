From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 Mar 2017 10:31:19 -0400
Subject: [PATCH V2] nvme-cli: fix nvme-list-ns documentation to match
 list_ns function
In-Reply-To: <1490105343-13236-1-git-send-email-guanjunxiong@huawei.com>
References: <1490105343-13236-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170321143119.GB19722@localhost.localdomain>

On Tue, Mar 21, 2017@10:09:03PM +0800, Guan Junxiong wrote:
> From: Junxiong Guan <guanjunxiong at huawei.com>
> 
> The list_ns function implements two command line options which is located in the line 496 to 499 of the nvme.c file but the manpage documentations of the nvme list-ns command only demostrate the first option i.e. the given namespace-id , leaving the second option i.e. all namesapces out. Therefore nvme-list-ns.1 , nvme-list-ns.html and nvme-lsit-ns.txt are corrected to match the actual implementation of the list_ns function.

Thanks for the update. I applied after adjusting the commit log to make
it multiple lines.
