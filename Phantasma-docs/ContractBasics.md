# Tomb Basic Knowledge Composition

## Tomb Compiler Usage:

_TombCompiler.exe options:optionvalue filename_

### **Options**:

protocol

- protocol of the blockchain you want to target. Default is the blockchain's current protocol version
- > TombCompiler.exe protocol:8 filename

output

- the path you want your compiled files to go. If the path does not exist then one will be created.
- > TombCompiler.exe output:file_path filename

debug:
~~Research under Construction~~

## Token Naming:

- must be 2-5 characters long

  - Must be uppercase
  - Using 5 characters yield 65780 possible combinations
  - Using 4 characters yields 14950 possible combinations
  - 3 yields 2600 ..etc

- **Examples**

  ```cs
  //valid examples
  token JUI{}
  token JUII{}
  token JUIII{}


  ```

## Contract Naming:

- must be 3-15 characters long

  - underscore allowed
  - must be lowercase
  - uppercase not allowed
  - numbers allowed for any character besides the 1st character

- **Examples**

```cs
//valid examples
contract _shaman{}
contract scp045{}
contract m_7g_po{}
contract calculus{}

```
