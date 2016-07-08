From: haleigh@edt.com (Haleigh Novak)
Date: Fri, 8 Jul 2016 16:43:16 +0000
Subject: NVME Power State Modification
In-Reply-To: <20160708160635.GA26619@localhost.localdomain>
References: <1467935716944.14813@edt.com>,
 <20160708160635.GA26619@localhost.localdomain>
Message-ID: <1467996196237.27514@edt.com>

>> I am currently working with the nvme power states - I need to keep everything in the nvme module, and I have a couple of questions:

>What do you want the module to do with power states, and when do you
>want it to change the states?

I am trying (for work) to put an nvme into an extreme low power state when idling and then be able to wake it up without issue. Currently it will not wake up fully/correctly [the /dev/nvme* files disappear when it goes into a low power state and I cant get them back unless I restart the machine], my attempt to explore this issue (as I am in the beginning stages of attempting to solve) was to first figure out how to change the power state from an extreme high power state to an extreme low power one - so it would be easier to see differences, that way I could find out if there was a floor power level that supported maintaining the /dev/nvme* files. Though because my nvme device only supports power states 0-4 (with max power of: 9W, 4.6W, 3.8W, 0.07W, and 0.005W) supported I felt I might need to modify one of the lower power states max/active/idle power values to retrieve a more exact value for the floor.

(I need to keep it within the module because this is an ongoing multi-layer project I was assigned and this power state issue is my next task.)

>> (1) Is it actually possible to modify the power states of the nvme?

>If you are just trying to test how the device responds, you can issue
>the set feature command from user space.

I have tried the set feature command through the nvme-cli interface as well as trying to modify the nvme_id_power_state object directly; in my print out of the power states the values change for the latter, however for both according to the nvme-cli "nvme id-ctrl /dev/nvme0" the change is not made permanently. I think the issue might be that I am not actually modifying the original nvme_id_ctrl->psd[i] object, that instead I am just modifying a copy thus the difference, but as I am new to this I figured it wouldst hurt to ask because thus far I haven't found in the spec sheet for the nvme where it specifically says I can/cant permanently modify the power state power values.

________________________________________
From: Keith Busch <keith.busch@intel.com>
Sent: Friday, July 8, 2016 9:06 AM
To: Haleigh Novak
Cc: linux-nvme at lists.infradead.org
Subject: Re: NVME Power State Modification

On Thu, Jul 07, 2016@11:55:17PM +0000, Haleigh Novak wrote:
> I am currently working with the nvme power states - I need to keep everything in the nvme module, and I have a couple of questions:

What do you want the module to do with power states, and when do you
want it to change the states?

> (1) Is it actually possible to modify the power states of the nvme?

If you are just trying to test how the device responds, you can issue
the set feature command from user space.
