From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 27 May 2015 22:28:20 +0000
Subject: [NVME-CLI] Status Update
Message-ID: <36F6EBABA23FEF4391AF72944D228901B6BE2CD7@BBYEXM01.pmc-sierra.internal>

Hi All

I just wanted to send out an update on the nvme-cli tool that Keith and I have been maintaining. We have performed a few upgrades over the past few months and based on traffic this tool seems to be getting some amount of usage. 

1. Code is available here - https://github.com/linux-nvme/nvme-cli
2. Code is now Apache licensed (except for the nvme.h file which of course has to be GPL). Hopefully this will encourage adoption.
3. Improved command line parsing using the argconfig library.
4. A few bug fixes and patches (thanks to all who have issued pull requests).
5. A nvme list command that generates a short bit of info on all the nvme devices attached to the host (including things like manufactured, capacity and supported format options).
6. A separate branch that supports lightNVM/OpenChannelSSD (https://github.com/OpenChannelSSD). This will be kept as a distinct branch and really just a tool for those of us who are working on this concept. There are no plans to merge this into master which will try to stay aligned to NVM Express.

The idea of nvme-cli is a simple CLI that is not vendor specific. Useful for those of us who have NVMe SSDs from multiple vendors in their servers (which is a nice problem to have). If you have any feature requests feel free to open an issue or, even better, implement it yourself and send us a pull request ;-).

Cheers

Stephen
