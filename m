From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 15 Sep 2017 21:02:56 -0400
Subject: [PATCHv2] nvme/pci: Print invalid SGL only once
In-Reply-To: <1505495138-11325-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Fri, 15 Sep 2017 13:05:38 -0400")
References: <1505495138-11325-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1lglftpz3.fsf@oracle.com>


Keith,

> The WARN_ONCE macro returns true if the condition is true, not if the
> warn was raised, so we're printing the scatter list every time it's
> invalid. This is excessive and makes debugging harder, so this patch
> prints it just once.



-- 
Martin K. Petersen	Oracle Linux Engineering
