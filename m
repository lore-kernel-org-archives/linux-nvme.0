From: rosattig@linux.vnet.ibm.com (=?UTF-8?Q?Rodrigo_Rosatti_Galv=c3=a3o?=)
Date: Fri, 30 Mar 2018 18:48:18 -0300
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <20180330212439.GA28945@localhost.localdomain>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
Message-ID: <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>


> Doesn't that mean your host is using this command wrong? The NLB is a
> 0's based value, we're supposed to +1 to get the correct block count.

Keith, I tested passing different values to the c (number of blocks) and 
s (64-bit LBA of first block to access) parameters, and it was failing. 
When I removed the +1, the command worked fine.

I used a simple script to validate this:

for s in {0..20}
 ??? do
 ??? ??? ??? for c in {0..20}
 ??? ??? ??? do
 ??? ??? ??????????? nvme write-zeroes /dev/nvme0 -n 10 -s $s -c $c
 ??? ??? ??? done
 ??? done


Is there some other way to test it?

-- 
Rodrigo R. Galv?o
Intern - Linux Technology Center - IBM
