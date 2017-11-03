From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Fri, 3 Nov 2017 13:56:11 +0100
Subject: [PATCH 2/3] nvme: compare NQN string with right size
In-Reply-To: <20171103125429.GB25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-3-git-send-email-javier@cnexlabs.com>
 <20171103125429.GB25186@lst.de>
Message-ID: <C8D5839F-0C9A-4B38-A694-2C3CB62D27AE@lightnvm.io>

> On 3 Nov 2017,@13.54, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Fri, Nov 03, 2017@11:02:49AM +0100, Javier Gonz?lez wrote:
>> Compare subnqns using NVMF_NQN_SIZE as it is < 256
>> 
>> Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
>> ---
>> drivers/nvme/host/core.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index bd1d5ff911c9..ae8ab0a1ef0d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1743,7 +1743,7 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>> 
>> 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
>> 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
>> -		strcpy(ctrl->subnqn, id->subnqn);
>> +		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
>> 		return;
>> 	}
> 
> This isn't a compare, but a copy.  Except for that it looks ok to me.

True. Can you change the message when picking it up?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171103/621572ad/attachment.sig>
