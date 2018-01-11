From: sathya.prakash@broadcom.com (Sathya Prakash Veerichetty)
Date: Thu, 11 Jan 2018 11:07:16 -0700
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <20180111174619.GA2860@localhost.localdomain>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20180108100531.GA6967@infradead.org>
 <35aabb7a8b8ffed4040c5ac01c01fb0a@mail.gmail.com>
 <1515601333.2745.8.camel@wdc.com>
 <d6da790a-8248-c71d-6643-6ae3107989d0@interlog.com>
 <e407e98c266c060412bfa8b64ded18df@mail.gmail.com>
 <20180111174619.GA2860@localhost.localdomain>
Message-ID: <780f280162fa01c41f15aaeb64503ffd@mail.gmail.com>

>>So even when used as a RAID member, there will be a device handle at
/dev/sdX for each NVMe device the megaraid controller manages?
In megaraid controller, you can expose bare NVMe drives and RAID volumes
created out of NVMe drives, when the RAID volume is created underlying
member drives will not have /dev/sdX entries associated with them, however
for bare NVMe drives there will be associated /dev/sdX entries.
