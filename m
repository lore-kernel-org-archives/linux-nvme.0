From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Feb 2018 11:54:15 +0200
Subject: [PATCH]nvme-pci: Fixes EEH failure on ppc
In-Reply-To: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
Message-ID: <75b6a9c1-dc58-6de4-7a87-eb77e8a73426@grimberg.me>



On 02/05/2018 11:49 PM, wenxiong@vmlinux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong at linux.vnet.ibm.com>
> 
> With b2a0eb1a0ac72869c910a79d935a0b049ec78ad9(nvme-pci: Remove watchdog
> timer), EEH recovery stops working on ppc.
> 
> After removing whatdog timer routine, when trigger EEH on ppc, we hit
> EEH in nvme_timeout(). We would like to check if pci channel is offline
> or not at the beginning of nvme_timeout(), if it is already offline,
> we don't need to do future nvme timeout process.

This makes sense to me.

Reviewed-by: Sagi Grimberg<sagi at grimberg.me>
