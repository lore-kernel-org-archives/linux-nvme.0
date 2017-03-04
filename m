From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Fri, 3 Mar 2017 22:43:16 -0300
Subject: [PATCH v3 01/16] lpfc: Correct WQ creation for pagesize
In-Reply-To: <58a0d919.08BhoypOnvRSLIqV%jsmart2021@gmail.com>
References: <58a0d919.08BhoypOnvRSLIqV%jsmart2021@gmail.com>
Message-ID: <6a197069-2f10-6df1-4cf1-1a62808c8903@linux.vnet.ibm.com>

Hi Martin and James,

On 02/12/2017 07:52 PM, James Smart wrote:
> Correct WQ creation for pagesize

Reviewed-by: Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com>


Please flag this patch for stable.

This patch resolves a serious problem on IBM Power systems at least.

An (apparently constant) series of invalid iotags cause a series of
SCSI command aborts that escalates into host reset, which fails too, 
bringing the adapter offline.

And it takes forever to boot, as udev waits on the initial SCSI I/O.

Thank you.


[   17.044690] lpfc 0000:01:00.1: 1:0372 iotag x0 is out off range: max 
iotag (x840)
...
[  723.680700] lpfc 0000:01:00.1: 1:(0):0714 SCSI layer issued Bus Reset 
Data: x2003
[  723.680873] lpfc 0000:01:00.1: 1:(0):3172 SCSI layer issued Host 
Reset Data:
[  724.052506] lpfc 0000:01:00.1: 1:0383 Error -5 during scsi sgl post 
operation
[  724.052701] lpfc 0000:01:00.1: 1:(0):3323 Failed host reset, bring it 
offline


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
