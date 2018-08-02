From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Thu, 2 Aug 2018 22:09:50 +0000
Subject: How /dev/nvme numbers are allocated/mapped to BDF
Message-ID: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>

Hi,

Recently some confusion came up about how the /dev/nvme numbers are 
allocated, and how much one can expect the to be consistent across 
reboots. I was fairly convinced that it was about as random as a coin 
flip, but some people have pointed out that these numbers were very 
deterministic in older kernels, dating back to the 3.10 era.

Were there some intentional changes along the way, or was this numbering 
scheme _never_ supposed to be deterministic in the first place?

Also, separate but related question. Samsung M1725a drives don't 
generate entries under /dev/disk/by-path. Any idea why that might be?

Alex
