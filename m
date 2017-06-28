From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 10:03:11 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <20170627162800.GA22592@obsidianresearch.com>
References: <614481c7-22dd-d93b-e97e-52f868727ec3@grimberg.me>
 <59FF0C04-2BFB-4F66-81BA-A598A9A087FC@oracle.com>
 <20170620173532.GA827@obsidianresearch.com>
 <D3DC49A2-FFC9-4F62-8876-3E6AD5167DE5@oracle.com>
 <20170620192742.GB827@obsidianresearch.com>
 <C14B071E-F1B2-466A-82CF-4E20BFAD9DC1@oracle.com>
 <20170620211958.GA5574@obsidianresearch.com>
 <4f0812f1-0067-4e63-e383-b913ee1f319d@grimberg.me>
 <28F6F58E-B6F4-4114-8DFF-B72353CE814B@oracle.com>
 <52ad3547-efcf-f428-6b39-117efda3379f@grimberg.me>
 <20170627162800.GA22592@obsidianresearch.com>
Message-ID: <6e52204f-427f-10d4-28f6-362027f8e811@grimberg.me>


> send completion mitigation is still possible, if it is OK for the
> backing pages to remain, but I think a more sophisticated strategy is
> needed - eg maybe push some kind of NOP through the send q after a
> timer or only complete when the last available work is stuffed or
> something.

I'm not smart enough to come up with something like that.
