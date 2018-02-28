From: wenxiong@linux.vnet.ibm.com (wenxiong)
Date: Wed, 28 Feb 2018 16:31:37 -0600
Subject: [PATCH V3] nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <1518725110-25894-1-git-send-email-wenxiong@linux.vnet.ibm.com>
References: <1518725110-25894-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Message-ID: <bf3a386a2b82dac84b681c14d5334632@linux.vnet.ibm.com>

On 2018-02-15 14:05, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong at linux.vnet.ibm.com>
> 
> With b2a0eb1a0ac72869c910a79d935a0b049ec78ad9(nvme-pci: Remove watchdog
> timer), EEH recovery stops working on ppc.
> 
> After removing whatdog timer routine, when trigger EEH on ppc, we hit
> EEH in nvme_timeout(). We would like to check if pci channel is offline
> or not at the beginning of nvme_timeout(), if it is already offline,
> we don't need to do future nvme timeout process.
> 
> Add mrmory barrier before calling pci_channel_offline().
> 
> With the patch, EEH recovery works successfuly on ppc.
> 
> Signed-off-by: Wen Xiong <wenxiong at linux.vnet.ibm.com>

Hi Keith and All,

We have the newer Linux distro releases came out recently, so I got more 
reports for this issue.

Test teams have verified the patch in several distro kernel 
version(v4.14, v4.15).


If you have any question about the V3 patch I submitted two weeks, Let 
me know.

Thanks,
Wendy
