From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jan 2018 10:46:20 -0700
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <e407e98c266c060412bfa8b64ded18df@mail.gmail.com>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20180108100531.GA6967@infradead.org>
 <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
 <1515601333.2745.8.camel@wdc.com>
 <d6da790a-8248-c71d-6643-6ae3107989d0@interlog.com>
 <e407e98c266c060412bfa8b64ded18df@mail.gmail.com>
Message-ID: <20180111174619.GA2860@localhost.localdomain>

On Wed, Jan 10, 2018@03:14:40PM -0700, Sathya Prakash Veerichetty wrote:
> In the case of RAID controllers, all of those drives and RAID volumes
> are exposed to the OS as generic SCSI devices

So even when used as a RAID member, there will be a device handle at
/dev/sdX for each NVMe device the megaraid controller manages?
